module RailsWorkflow
  class OperationTemplateSerializer < ActiveModel::Serializer
    attributes :uuid, :title, :source, :dependencies, :operation_class,
               :async, :assignment_id, :assignment_type, :kind, :role, :group, :instruction,
               :is_background, :type, :partial_name, :version, :tag

    has_one :child_process, serializer: RailsWorkflow::OperationTemplateSerializer

    def dependencies
      object.dependencies.each do |d|
        d['uuid'] = OperationTemplate.find(d['id']).uuid
        d.delete("id")
      end
    end

    def operation_class
      object.read_attribute :operation_class
    end

  end
end
