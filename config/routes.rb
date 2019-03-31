Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'candidate_schedules/' => 'api#candidate_schedules'
      post 'schedule_interview/' => 'api#schedule_interview'
    end
  end
end
