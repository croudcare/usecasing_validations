require "usecasing-validations/validations/base"
require "usecasing-validations/validations/errors"
require "usecasing-validations/validations/helper_methods"
require "usecasing-validations/validations/validator"

require "usecasing-validations/validations/format_validator"
require "usecasing-validations/validations/length_validator"
require "usecasing-validations/validations/presence_validator"
require "usecasing-validations/validations/uniqueness_validator"

module UseCase
  
  class Validator < Base

    include Validations::Base
    
    def perform
      targets = [*target]

      if targets.empty?
        all_validations_green = false
      else
        all_validations_green = targets.map do |object_to_validate|
          if self.class._marked_for_destruction?(object_to_validate)
            true
          else
            valid?(object_to_validate)
          end
        end.all?
      end

      failure(self.class.to_s.downcase.to_sym, :failed) unless all_validations_green
    end

  end

end