module Hyper
  module Core
    module Service
      class Error < StandardError;
      end
      class UnauthorizedUserError < Error;
      end
      class NotFoundError < Error;
      end
      class InternalServerError < Error;
      end
    end
  end
end
