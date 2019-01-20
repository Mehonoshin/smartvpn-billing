# frozen_string_literal: true

module AdminHelper
  def menu_item(title, path, fa_icon)
    content_tag :li, class: 'nav-item' do
      link_to path, class: 'nav-link' do
        content_tag(:i, '', class: "fa fa-lg fa-fw fa-#{fa_icon}") +
          content_tag(:span, title, class: 'pl-3')
      end
    end
  end

  def menu_item_with_sub(title, path, fa_icon)
    if block_given?
      sub_menu = content_tag :ul, id: path[1..-1], class: 'collapse list-unstyled ml-3' do
        yield
      end.html_safe
    end
    content_tag :li, class: 'nav-item' do
      link_to path, class: 'nav-link dropdown-toggle', 'data-toggle': 'collapse', 'aria-expanded': 'false' do
        content_tag(:i, '', class: "fa fa-lg fa-fw fa-#{fa_icon}") +
          content_tag(:span, title, class: 'pl-3')
      end.concat(sub_menu)
    end
  end

  def sub_menu_item(title, path)
    content_tag :li, class: 'nav-item' do
      link_to title, path, class: 'nav-link'
    end
  end

  def page_title(section, icon, subsection = nil)
    content_tag :h3, class: 'page-title txt-color-blueDark' do
      content_tag(:i, '', class: "fa-fw fa fa-#{icon}") +
        content_tag(:span, "#{section} ", class: 'pl-3') +
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

  def change_locale_link
    Web::Admin::ChangeLocaleLinkCell.new.render
  end
end
