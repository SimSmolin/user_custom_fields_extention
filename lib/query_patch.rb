require_dependency 'query'

module QueryCustomFieldColumnPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable
      alias_method :value_object, :value_object_with_patch # method "value_object" was modify
    end
  end

  module InstanceMethods
    def value_object_with_patch(object)
      if object.is_a?(User)
        if custom_field.visible_by?(nil, User.current)
          cv = object.custom_values.select {|v| v.custom_field_id == @cf.id}
          cv.size > 1 ? cv.sort {|a,b| a.value.to_s <=> b.value.to_s} : cv.first
        else
          nil
        end
      else
        if custom_field.visible_by?(object.project, User.current)
          cv = object.custom_values.select {|v| v.custom_field_id == @cf.id}
          cv.size > 1 ? cv.sort {|a,b| a.value.to_s <=> b.value.to_s} : cv.first
        else
          nil
        end
      end
    end
  end
end
