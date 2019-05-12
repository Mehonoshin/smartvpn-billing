# frozen_string-literal: true

require 'rails_helper'

describe Web::Admin::ChangeLocaleLinkCell do
  subject { described_class.new }

  context 'current locale is EN' do
    it 'returns alink to chane the locale to RU' do
      expect(subject.render).to eq '<li class="nav-item"><a class="nav-link" rel="nofollow" data-method="put" href="/admin/change_languages?locale=ru">EN</a></li>'
    end
  end

  context 'current locale is RU' do
    before { I18n.locale = :ru }

    after { I18n.locale = :en }

    it 'returns alink to chane the locale to EN' do
      expect(subject.render).to eq '<li class="nav-item"><a class="nav-link" rel="nofollow" data-method="put" href="/admin/change_languages?locale=en">RU</a></li>'
    end
  end
end
