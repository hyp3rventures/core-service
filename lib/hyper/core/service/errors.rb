module Hyper
  module Core
    module Service
      class Error < StandardError
        attr_reader :message
      end
      class UnauthorizedUserError < Error; end
      class NotFoundError < Error; end
      class InternalServerError < Error; end
      class MissingParamsError < Error
        def initialize(message)
          @message = message
        end
      end
    end
  end
end
