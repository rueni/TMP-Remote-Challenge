Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  namespace 'api' do
    namespace 'v1' do
      get 'candidate_schedules/' => 'api#candidate_schedules'
      post 'schedule_interview/' => 'api#schedule_interview'
    end
  end
end
