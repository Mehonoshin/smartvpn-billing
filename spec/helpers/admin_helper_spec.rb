# frozen_string_literal: true

require 'rails_helper'

describe AdminHelper do
  describe '#menu_item_with_sub' do
    context 'without block' do
      let(:result) { '<li class="nav-item"><a class="nav-link dropdown-toggle" data-toggle="collapse" aria-expanded="false" href="path"><i class="fa fa-lg fa-fw fa-user"></i><span class="pl-3">title</span></a></li>' }

      it 'returns one link' do
        expect(menu_item_with_sub('title', 'path', 'user')).to eq result
      end
    end

    context 'with block' do
      let(:result) { '<li class="nav-item"><a class="nav-link dropdown-toggle" data-toggle="collapse" aria-expanded="false" href="path"><i class="fa fa-lg fa-fw fa-user"></i><span class="pl-3">title</span></a><ul id="ath" class="collapse list-unstyled ml-3">test</ul></li>' }

      it 'returns one link' do
        expect(menu_item_with_sub('title', 'path', 'user') { 'test' }).to eq result
      end
    end
  end

  describe '#menu_item' do
    let(:result) { '<li class="nav-item"><a class="nav-link" href="path"><i class="fa fa-lg fa-fw fa-user"></i><span class="pl-3">title</span></a></li>' }

    it 'returns one link' do
      expect(menu_item('title', 'path', 'user')).to eq result
    end
  end

  describe '#sub_menu_item' do
    let(:result) { '<li class="nav-item pl-4"><a class="nav-link" href="path">title</a></li>' }

    it 'returns one link' do
      expect(sub_menu_item('title', 'path')).to eq result
    end
  end

  describe '#change_locale_link' do
    let(:cell) { double('Web::Admin::ChangeLocaleLinkCell') }

    before { allow(Web::Admin::ChangeLocaleLinkCell).to receive(:new).and_return(cell) }

    it 'runs Web::Admin::ChangeLocaleLinkCell' do
      expect(cell).to receive(:render)
      change_locale_link
    end
  end

  describe '#page_title' do
    context 'without block' do
      let(:result) do
        '<h3><i class="fa-fw fa fa-user"></i><a class="mx-2 text-dark" href="/admin/users">title</a></h3>'
      end

      it 'returns one link' do
        expect(page_title('title', 'user', 'users')).to eq result
      end
    end

    context 'with block' do
      let(:result) do
        '<h3><i class="fa-fw fa fa-user"></i><a class="mx-2 text-dark" href="/admin/users">title</a>test</h3>'
      end

      it 'returns one link' do
        expect(page_title('title', 'user', 'users') { 'test' }).to eq result
      end
    end
  end

  describe '#sub_page_title' do
    let(:result) { '<span>&gt; title</span>' }

    it 'returns one link' do
      expect(sub_page_title('title')).to eq result
    end
  end
end
