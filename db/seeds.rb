# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(:name => Setting.roles.super_admin)

admin_permissions = Permission.create(:name => Setting.permissions.super_admin, :subject_class => Setting.admins.class_name, :action => "manage")

role.permissions << admin_permissions

user = User.new(:phone => Setting.admins.phone, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)
user.save!

user.roles = []
user.roles << role

AdminUser.create!(:phone => Setting.admins.phone, :email => Setting.admins.email, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)

#@user = User.create!(:phone => "15763703188", :password => "15763703188", :password_confirmation => "15763703188")

###区分厂区和集团用户是为了sidebar显示
@role_fct = Role.where(:name => Setting.roles.role_fct).first
@role_grp = Role.where(:name => Setting.roles.role_grp).first


##厂区管理者
@fct_mgn = [@role_fct]
##集团管理者
@grp_mgn = [@role_grp]


@jiax = Company.create!(:area => "嘉祥县", :name => "嘉祥水务")
@wens = Company.create!(:area => "汶上县", :name => "汶上水务")
@yanz = Company.create!(:area => "兖州区", :name => "兖州水务")
@zouc = Company.create!(:area => "邹城市", :name => "邹城水务")
@lish = Company.create!(:area => "梁山县", :name => "梁山水务")

@jxws  = Factory.create!(:area => "嘉祥县",     :name => "嘉祥水务",     :company => @jiax, :lnt => 116.344578, :lat => 35.397421, :design => 80000)
@wsqy  = Factory.create!(:area => "汶上县",     :name => "汶上水务", :company => @wens, :lnt => 116.480951, :lat => 35.712144, :design => 40000)
@yzws  = Factory.create!(:area => "兖州区",     :name => "兖州水务",     :company => @yanz, :lnt => 116.781921, :lat => 35.510729, :design => 60000)
@zcdy  = Factory.create!(:area => "邹城市",     :name => "邹城水务", :company => @zouc, :lnt => 116.944881, :lat => 35.384207, :design => 80000)
@lsws  = Factory.create!(:area => "梁山县",     :name => "梁山水务", :company => @lish, :lnt => 116.918884, :lat => 35.457138, :design => 60000)


User.create!(:phone => "12305378989", :password => "jxws8989", :password_confirmation => "jxws8989", :name => "嘉祥水务运营管理部", :roles => @fct_mgn, :factories => [@jxws])
User.create!(:phone => "053795661234", :password => "wsqy9566", :password_confirmation => "wsqy9566", :name => "汶上水务运营管理部", :roles => @fct_mgn, :factories => [@wsqy])
User.create!(:phone => "053766661818", :password => "yzdy1818", :password_confirmation => "yzdy1818", :name => "兖州水务运营管理部", :roles => @fct_mgn, :factories => [@yzws])
User.create!(:phone => "053700009999", :password => "zcds9999", :password_confirmation => "zcds9999", :name => "邹城水务运营管理部", :roles => @fct_mgn, :factories => [@zcdy])
User.create!(:phone => "053798989188", :password => "bhws9188", :password_confirmation => "bhws9188", :name => "梁山水务运营管理部", :roles => @fct_mgn, :factories => [@lsws])


all_factories = Factory.all
user.factories << all_factories

#集团运营
#grp_opt = User.create!(:phone => "15763703588", :password => "swjt3588", :password_confirmation => "swjt3588", :name => "水务集团运营", :roles => @grp_opt, :factories => all_factories)

#集团管理

grp_mgn = User.create!(:phone => "1236688", :password => "swjt6688", :password_confirmation => "swjt6688", :name => "水务集团运营管理部", :roles => @grp_mgn, :factories => all_factories)
