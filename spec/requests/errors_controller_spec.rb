require 'rails_helper'

RSpec.describe 'errors', type: :request do
  it 'displays the 401 page' do
    get '/401'
    expect(response).to have_http_status(:unauthorized)
  end

  it 'displays the 404 page' do
    get '/404'
    expect(response).to have_http_status(:not_found)
  end

  it 'displays the 500 page' do
    get '/500'
    expect(response).to have_http_status(:internal_server_error)
  end
end
