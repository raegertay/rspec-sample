require 'rails_helper'

RSpec.describe PenguinsController, type: :controller do

  describe 'GET #index' do
    let!(:penguin) { create(:penguin) }
    before { get :index }
    it { expect(assigns(:penguins).count).to eq(1) }
  end

  describe 'GET #new' do
    before { get :new }
    it { expect(assigns(:penguin)).to be_a_new(Penguin) }
  end

  describe 'GET #show' do
    let!(:penguin) { create(:penguin) }
    before { get :show, params: { id: penguin.id } }
    it { expect(assigns(:penguin)).to eq(penguin) }
  end

  describe 'POST #create' do

    before { post :create, params: penguin_params }

    context 'when save is successful' do
      let(:penguin_params) do
        {
          penguin: attributes_for(:penguin)
        }
      end
      it { is_expected.to redirect_to(penguins_path) }
    end

    context 'when save is unsuccessful' do
      let(:penguin_params) do
        {
          penguin: attributes_for(:penguin, :invalid)
        }
      end
      it { is_expected.to render_template(:new) }
    end

  end

  describe 'GET #edit' do

    let(:penguin) { create(:penguin) }

    before { get :edit, params: { id: penguin.id } }

    it { expect(assigns(:penguin)).to eq(penguin) }

  end

  describe 'PUT/PATCH #update' do

    let(:penguin) { create(:penguin) }

    before { put :update, params: params }

    context 'when update is successful' do

      let(:params) do
        {
          id: penguin.id,
          penguin: attributes_for(:penguin, head: 'cute')
        }
      end

      it { is_expected.to redirect_to(penguins_path) }

    end

    context 'when update is unsuccessful' do

      let(:params) do
        {
          id: penguin.id,
          penguin: attributes_for(:penguin, :invalid)
        }
      end

      it { is_expected.to redirect_to(penguins_path) }
      it { expect(subject).to set_flash[:error] }
      it { expect(flash[:error]).to eq('Failed to create penguin') }

    end

  end

end
