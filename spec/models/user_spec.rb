require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }
describe "when password is not present" do
  before { @user.password = @user.password_confirmation = " " }
  it { should_not be_valid }
end
describe "when password doesn't match confirmation" do
  before { @user.password_confirmation = "mismatch" }
  it { should_not be_valid }
end
  describe "when name is not present" do #Проверка на наличие имени
    before { @user.name = " " }
    it { should_not be_valid }
  end
    describe "when email is not present" do   #Проверка на наличие мыла
    before { @user.email = " " }
    it { should_not be_valid }
  end
    describe "when name is too long" do 
    before { @user.name = "a" * 51 }      
    it { should_not be_valid } # Проверка максимальной длины имени (не больше 50 символов)
  end

    describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]					#Создание массива с неправильными адресами адресами
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid				#Проверка на непройденую валидацию каждого из массива адресов
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]  #Создание массива коректных адресов
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid		#Проверка на прохождение валидации 
      end
    end
  end
    describe "when email address is already taken" do #Тест на отклонение дублирующихся адресов электронной почты
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
    describe "email address with mixed case" do #Тест для кода отвечающего за перевод email в нижний регистр
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
  describe "when email address is already taken" do   #Нечувствительный к регистру тест на отклонение дублирующихся адресов электронной почты
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
    describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end