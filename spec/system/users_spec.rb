require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_pass root_path
      # トップページに「新規登録」の表示があることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      click_link "新規登録"
      # ユーザー情報を入力する
      expect(page).to have_content('会員情報入力')
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name_reading]', with: @user.last_name_reading
      fill_in 'user[first_name_reading]', with: @user.first_name_reading
      select @user.birth_date.year, from: 'user[birth_date(1i)]'
      select @user.birth_date.month, from: 'user[birth_date(2i)]'
      select @user.birth_date.day, from: 'user[birth_date(3i)]'
      # 「新規登録」ボタンをクリックするとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに「ユーザーのニックネーム」ボタンが表示があることを確認する
      expect(page).to have_content(@user.nickname)
      # トップページに「ログアウト」ボタンが表示があることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      basic_pass root_path
      # トップページに「新規登録」の表示があることを確認する
      click_link "新規登録"
      # 新規登録ページへ移動する
      expect(page).to have_content('会員情報入力')
      # ユーザー情報を入力しない
      # 「新規登録」ボタンをクリックしてもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      basic_pass root_path
      # トップページに「ログイン」の表示があることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      click_link "ログイン"
      # 登録済みのユーザー情報を入力する
      expect(page).to have_content('会員情報入力')
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # 「ログイン」ボタンをクリックするとトップページへ遷移することを確認する
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページに「ユーザーのニックネーム」ボタンが表示があることを確認する
      expect(page).to have_content(@user.nickname)
      # トップページに「ログアウト」ボタンが表示があることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      basic_pass root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      click_link "ログイン"
      # ユーザー情報を入力しない
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end