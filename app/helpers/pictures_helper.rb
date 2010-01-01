module PicturesHelper
  def load_my_two_users
    @preston = User.find_by_name('Preston')
    @alexis = User.find_by_name('Alexis')
  end
end
