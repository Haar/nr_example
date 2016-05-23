require 'rails_helper'

describe PostPolicy do
  let!(:author) { User.create email: 'author@example.com', password: 'password' }
  let!(:model) { Post.create user: author, title: 'Title', body: 'content' }

  subject { described_class.new(user, model)  }

  context 'when an anon user' do
    let(:user) { nil }

    it { is_expected.to_not permit_auth :create }
    it { is_expected.to_not permit_auth :edit }
    it { is_expected.to_not permit_auth :query }
  end

  context 'when a standard user' do
    let(:user) { User.new }

    it { is_expected.to     permit_auth :create }
    it { is_expected.to_not permit_auth :edit }
    it { is_expected.to_not permit_auth :query }

    context 'when the post author' do
      let(:user) { author }

      it { is_expected.to permit_auth :edit }
    end
  end

  context 'when an admin user' do
    let(:user) { User.new(admin: true) }

    it { is_expected.to permit_auth :edit }
    it { is_expected.to permit_auth :query }
  end

  describe PostPolicy::Scope do
    subject { PostPolicy::Scope.new(user, Post.all).resolve }
    let!(:other_post) { Post.create title: 'other post', body: 'content' }

    context 'when a standard user' do
      let(:user) { author } # User.new

      it { is_expected.to match_array [model] }
    end

    context 'when an admin user' do
      let(:user) { User.new(admin: true) }

      it { is_expected.to match_array [model, other_post] }
    end
  end
end
