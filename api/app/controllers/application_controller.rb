# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def process_single(data)
    render(
      status: :ok,
      json: {
        status: Rack::Utils::HTTP_STATUS_CODES[200],
        message: 'Your request has been processed successfully.',
        data: data
      }
    )
  end

  def process_collection(data)
    data = data.page(params[:page]).per(params[:per_page])

    render(
      status: :ok,
      json: {
        status: Rack::Utils::HTTP_STATUS_CODES[200],
        message: 'Your request has been processed successfully.',
        data: data,
        page: {
          current_page: data.current_page,
          prev_page: data.prev_page,
          next_page: data.next_page,
          per_page: data.limit_value,
          total_pages: data.total_pages
        }
      }
    )
  end

  def process_error(code, problems = [])
    render(
      status: code,
      json: {
        status: Rack::Utils::HTTP_STATUS_CODES[code],
        message: 'Sorry, the server was unable to process your request.',
        problems: problems
      }
    )
  end
end
