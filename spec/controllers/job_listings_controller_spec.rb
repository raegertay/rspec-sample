require 'rails_helper'

# describe -> one for each method
# context -> for if/else branch
# it -> one for each test
# before -> to be run before each 'it' block

RSpec.describe JobListingsController, type: :controller do

  # let(:user) { create(:user) }
  # before do
  #   sign_in user
  # end

  # Instance method is preceded by '#'
  describe 'GET #index' do
    let!(:job_listing) { create_list(:job_listing, 3) }
    before { get :index }
    it { expect(assigns(:job_listings).count).to eq(3) }
  end

  describe 'GET #new' do
    before { get :new }
    # it { expect(assigns(:job_listing)).to be_instance_of(JobListing) }
    # it { expect(assigns(:job_listing)).to be_a(JobListing) }
    # it { expect(assigns(:job_listing)).to be_an(JobListing) }
    # it { expect(assigns(:job_listing)).to be_kind_of(JobListing) }
    it { expect(assigns(:job_listing)).to be_a_new(JobListing) }
  end

  describe 'GET #show' do
    let!(:job_listing) { create(:job_listing) }
    before { get :show, params: { id: job_listing.id } }
    it { expect(assigns(:job_listing)).to eq(job_listing) }
  end

  describe 'POST #create' do

    let(:user) { create(:user) }

    before do
      sign_in user
      post :create, params: job_listings_params
    end

    context 'when save is successful' do
      let(:job_listings_params) do
        {
          job_listing: attributes_for(:job_listing)
        }
      end
      it { expect(subject).to redirect_to(job_listings_path) }
      it { is_expected.to redirect_to(job_listings_path) }
    end

    context 'when save is unsuccessful' do
      let(:job_listings_params) do
        {
          job_listing: attributes_for(:job_listing, :invalid)
        }
      end
      it { expect(subject).to render_template(:new) }
      it { is_expected.to render_template(:new) }
    end

  end

  describe 'GET #edit' do

    let!(:job_listing) { create(:job_listing) }

    before { get :edit, params: { id: job_listing.id } }

    it { expect(assigns(:job_listing)).to eql(job_listing) }

  end

  describe 'PUT/PATCH #update' do

    let!(:job_listing) { create(:job_listing) }

    before { put :update, params: params }

    context 'when update is successful' do

      let(:params) do
        {
          id: job_listing.id,
          job_listing: attributes_for(:job_listing, salary: 2000)
        }
      end

      it { expect(subject).to redirect_to(job_listings_path) }
      it { expect(assigns(:job_listing)).to have_attributes(salary: 2000) }

    end

    context 'when update is unsuccessful' do

      let(:params) do
        {
          id: job_listing.id,
          job_listing: attributes_for(:job_listing,:invalid)
        }
      end

      it { expect(subject).to render_template(:edit) }

    end

  end

  describe 'DELETE #destroy' do

    let(:job_listing) { create(:job_listing) }

    before { delete :destroy, params: { id: job_listing.id } }

    it { expect(assigns(:job_listing)).to eq(job_listing) }
    it { expect(assigns(:job_listing)).to be_destroyed }
    it { expect(assigns(:job_listing)).not_to be_persisted }
    it { expect(assigns(:job_listing)).to_not be_persisted }
    it { is_expected.to redirect_to(job_listings_path) }

  end

end
