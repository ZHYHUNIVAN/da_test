module Interactors
  class Base
    include Interactor

    def params
      return @params if @params
      @params = context.params || {}
    end
  end
end