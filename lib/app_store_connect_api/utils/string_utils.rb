# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module StringUtils
      class << self
        def camelize(snake_cased_word)
          snake_cased_word.split('_')
                          .map(&:capitalize)
                          .join
                          .tap { |w| w[0] = w[0].downcase }
        end

        def underscore(camel_cased_word)
          camel_cased_word.gsub(/([a-z])([A-Z])/, '\1_\2')
                          .downcase
        end

        def pluralize(word)
          if word.end_with? 's'
            word + 'es'
          elsif word.end_with? 'y'
            word[...-1] + 'ies'
          else
            word + 's'
          end
        end
      end
    end
  end
end
