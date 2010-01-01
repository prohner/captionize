class AddTestData < ActiveRecord::Migration
  def self.up
    Picture.delete_all
    User.delete_all
    Caption.delete_all
    
    user1 = User.create(:name => 'Preston',
                        :email => 'preston@preston.com')
    pic1 = Picture.create(:headline => 'Preston\'s favorite picture',
                          :path_to_picture => 'uploads/rails.png')

    cap1 = Caption.create(:headline => 'What is up with that????')  
    pic1.captions << cap1
    pic1.save
    
    user1.pictures << pic1
    user1.captions << cap1
    user1.save
    
    user2 = User.create(:name => 'Alexis',
                        :email => 'alexis@alexis.com')
    pic2 = Picture.create(:headline => 'Alexis\'s favorite picture',
                          :path_to_picture => 'uploads/svn.jpg')  

    cap2 = Caption.create(:headline => 'That is whacked stuff')  
    pic2.captions << cap2
    pic2.save

    user2.pictures << pic2
    user2.captions << cap2
    user2.save
                        
  end

  def self.down
    Picture.delete_all
    User.delete_all
    Caption.delete_all
  end
end
