# frozen_string_literal: true

module AdminHelper
  def menu_item(title, path, fa_icon)
    content_tag :li do
      link_to path do
        content_tag(:i, '', class: "fa fa-lg fa-fw fa-#{fa_icon}") +
          content_tag(:span, class: 'menu-item-parent') do
            title
          end +
          if block_given?
            content_tag :ul do
              yield
            end
          end
      end
    end
  end

  def sub_menu_item(title, path)
    content_tag :li do
      link_to title, path
    end
  end

  def page_title(section, icon, subsection = nil)
    content_tag :h1, class: 'page-title txt-color-blueDark' do
      content_tag(:i, '', class: "fa-fw fa fa-#{icon}") +
        "#{section} " +
        content_tag(:span) do
          "> #{subsection}" if subsection
        end
    end
  end

  def human_connection(type)
    if type == 'Connect'
      content_tag :span, class: 'green' do
        'Подключение'
      end
    else
      content_tag :span, class: 'red' do
        'Отключение'
      end
    end
  end

  def human_traffic(traffic)
    "#{bytes_to_gigabytes traffic} GB"
  end

  def bytes_to_gigabytes(traffic)
    BytesConverter.prettify_float(BytesConverter.bytes_to_gigabytes(traffic))
  end

  def descrete_statistic_values(sequence)
    sequence.to_s.delete('[').delete(']')
  end

  def human_course(course)
    course.round(4)
  end

  def can_be_prolongated?(user)
    user.paid?
  end

  def object_states_select_collection(class_name)
    class_name.state_machine.states.map do |s|
      [s.name.capitalize, s.name]
    end
  end

  def background_highlight(user)
    user.confirmed? ? 'confirmed' : 'not-confirmed'
  end

  def check_box_search(name)
    if params[:q] && params[:q][name]
      check_box_tag 'q[never_paid_eq]', params[:q][:never_paid_eq], params[:q][:never_paid_eq] == '1'
    else
      check_box_tag 'q[never_paid_eq]'
    end
  end
end
