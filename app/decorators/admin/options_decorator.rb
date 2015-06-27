class Admin::OptionsDecorator < Draper::Decorator
  delegate_all

  def state
    h.content_tag :span, class: object_classes do
      object.state
    end
  end

  private

  def object_classes
    classes = ['state']
    active = active? ? 'active' : 'disabled'
    classes << active
  end

  def active?
    object.active?
  end

end
