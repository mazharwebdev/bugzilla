class Foo < ContentfulModel::Base
   self.content_type_id = "item"

   coerce_field name: :Name
   coerce_field store_id: :Integer
end