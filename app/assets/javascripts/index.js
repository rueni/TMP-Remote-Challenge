document.addEventListener("DOMContentLoaded", event =>{
  $("#results").hide();
  $("#result-alert-container").hide();
  $("#flatpickr-input").flatpickr({
    enableTime: true,
    altInput: true,
    defaultDate: new Date().toISOString(),
    minDate: 'today',
    minTime: "08:00",
    maxTime: "18:00",
    disable: [date => {
        let day = date.getDay();
        return (day == 0 || day == 6);
      },
    ],
    onBlur: (rawdate, altdate, FPOBJ) => {
      FPOBJ.close(); // Close datepicker on date select
    },
    onChange: (rawdate, altdate, FPOBJ) => {
      $("#search-button").fadeIn();
      $("#results").fadeOut();
      $('#result-alert-container').hide();
    }
  });
})

function validateCount(input) {
  $('#result-alert-container').hide();
  if (!input.checkValidity()) {
    input.classList.add('is-invalid')
    setTimeout(() => {
      input.reportValidity();
    }, 1);
  } else {
    input.classList.remove('is-invalid')
    if ($('#search-button').is(":hidden")) {
      $("#search-button").fadeIn();
      $("#results").hide();
    }
  }
}

function clickSearch(e) {
  e.preventDefault();
  let countEl = $("#count-input")[0];
  let selected_time = $("#flatpickr-input")[0].value;
  if (countEl.validity.valid && selected_time != '') {
    let { value } = countEl
    $.ajax({
      url: `api/v1/candidate_schedules/?count=${value}`,
      type: "GET",
      success: response => {
        console.log('search response', response);
        $('#selectList').find('option').remove()
        $('#selectList').append(new Option('Choose a slot...', ''));
        const { data } = response;
        if (data.length > 0) {
          data.forEach(option => {
            let date = new Date(option.availability);
            let n = date.toDateString();
            let time = date.toLocaleTimeString();
            $("#selectList").append(new Option(`# ${option.slot_id} - ${n} ${time}`, option.slot_id));
          })
          $("#search-button").hide();
          $("#results").fadeIn();
        } else{
          $('#result-alert-container').find('div')[0].classList.remove('alert-success');
          $('#result-alert-container').find('div')[0].classList.add('alert-danger');
          $('#result-title').text('Error');
          $('#result-text').text(`Your search did not find any open slots.  Please expand your search`);
          setTimeout(() => {
            $('#result-alert-container').fadeOut()
          }, 2500);
        }
      },
      error: error => {
        $('#result-alert-container').find('div')[0].classList.remove('alert-success');
        $('#result-alert-container').find('div')[0].classList.add('alert-danger');
        $('#result-title').text('Error');
        $('#result-text').text(`Your request failed.  Please try again, at another time`);
        setTimeout(() => {
          $('#result-alert-container').fadeOut()
        }, 2500);
      }
    });
  }
}

function clickSubmit(e) {
  e.preventDefault();
  let slot_id = $('#selectList')[0].value
  if (!slot_id) { return; }

  let selected_time = new Date($("#flatpickr-input")[0].value).toISOString();
  $.ajax({
    url: "api/v1/schedule_interview",
    type: "POST",
    dataType: "json",
    data: { slot_id, selected_time },
    success: response => {
      console.log('submit response', response)
      let readable_selected_time = new Date(selected_time)
      $('#result-alert-container').find('div')[0].classList.remove('alert-danger');
      $('#result-alert-container').find('div')[0].classList.add('alert-success');
      $('#result-title').text('Success');
      $('#result-text').text(`Your request to book inteview slot ${slot_id} at ${readable_selected_time} has been fulfilled`);
      $('#result-alert-container').show();
      setTimeout(() => {
        $('#result-alert-container').fadeOut()
      }, 2500);
    },
    error: error => {
      console.log('error', error);
      $('#result-alert-container').find('div')[0].classList.remove('alert-success');
      $('#result-alert-container').find('div')[0].classList.add('alert-danger');
      $('#result-title').text('Error');
      $('#result-text').text(`The time you requested is not currently available.  Please try again.`);
      $('#result-alert-container').show();
      setTimeout(() => {
        $('#result-alert-container').fadeOut()
      }, 2500);
    }
  });
};
