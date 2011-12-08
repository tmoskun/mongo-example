module MongoMapperExt
  module Plugins
    module Associations           
      module ClassMethods      
        def reflect_on_association(association)
          #puts associations[association].inspect if associations[association]
          associations[association].extend AssociationMethods if associations[association]
        end
      end
      module AssociationMethods
        def macro
          @macro = derive_macro
        end
        def primary_key_name
           @primary_key_name ||= options[:foreign_key] || derive_primary_key_name
        end
        def belongs_to?
          @macro == :belongs_to
        end
        
        private
         def derive_primary_key_name
          if belongs_to?
            "#{name}_id"
          elsif options[:as]
            "#{options[:as]}_id"
          else
            klass.foreign_key
          end
        end
        
        def derive_macro
          case self.class.name
            when "MongoMapper::Plugins::Associations::BelongsToAssociation"
                :belongs_to
            when "MongoMapper::Plugins::Associations::ManyAssociation"
                :has_many
            when "MongoMapper::Plugins::Associations::OneAssociation"
                :has_one
            else
              "unknown association"
          end
        end
      end
    end     
  end
end

MongoMapper::Document.send(:include, MongoMapperExt::Plugins::Associations)