Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      get 'candidate_schedules/' => 'api#candidate_schedules'
      post 'schedule_interview/' => 'api#schedule_interview'
    end
  end
end
