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

@role_device    = Role.where(:name => Setting.roles.role_device).first
@role_inspector = Role.where(:name => Setting.roles.role_inspector).first
@role_worker    = Role.where(:name => Setting.roles.role_worker).first
@role_sign_log  = Role.where(:name => Setting.roles.role_sign_log).first

@role_grp_device    = Role.where(:name => Setting.roles.role_grp_device).first
@role_grp_inspector = Role.where(:name => Setting.roles.role_grp_inspector).first
@role_grp_worker    = Role.where(:name => Setting.roles.role_grp_worker).first
@role_grp_sign_log  = Role.where(:name => Setting.roles.role_grp_sign_log).first

##厂区管理者
@fctmgn = [@role_fct, @role_worker, @role_device, @role_inspector, @role_sign_log]
##集团管理者
@grp_mgn = [@role_grp, @role_grp_worker, @role_grp_device, @role_grp_inspector, @role_grp_sign_log]

@lssw = Company.create!(:area => "梁山县", :name => "中国建筑第六工程局有限公司")
@zouc = Company.create!(:area => "邹城市", :name => "青岛亿联建设集团股份有限公司")
@jiax = Company.create!(:area => "嘉祥县", :name => "中建生态环境集团有限公司")
@yanz = Company.create!(:area => "兖州区", :name => "兖州农污工程建设")
#@wens = Company.create!(:area => "汶上县", :name => "汶上农污工程建设")
#@qufu = Company.create!(:area => "曲阜市", :name => "曲阜农污工程建设")
#@renc = Company.create!(:area => "任城区", :name => "任城农污工程建设")
#@beih = Company.create!(:area => "太白湖新区", :name => "北湖农污工程建设")
#@jinx = Company.create!(:area => "微山县", :name => "微山农污工程建设")

@lssw  = Factory.create!(:area => "梁山县",     :name => "中国建筑第六工程局有限公司",       :company => @lssw, :lnt => 116.131779, :lat => 35.765957, :design => 20000)
@zcsw  = Factory.create!(:area => "邹城市",     :name => "青岛亿联建设集团股份有限公司",       :company => @zouc, :lnt => 117.007406, :lat => 35.402536, :design => 80000)
@jxsw  = Factory.create!(:area => "嘉祥县",     :name => "中建生态环境集团有限公司",       :company => @jiax, :lnt => 116.342308, :lat => 35.40794, :design => 80000)
@yzsw  = Factory.create!(:area => "兖州区",     :name => "兖州农污工程建设",       :company => @yanz, :lnt => 116.78365, :lat => 35.551938, :design => 60000)
#@wssw  = Factory.create!(:area => "汶上县",     :name => "汶上农污工程建设",       :company => @wens, :lnt => 116.497277, :lat => 35.711891, :design => 40000)
#@qfsw  = Factory.create!(:area => "曲阜市",     :name => "曲阜农污工程建设",       :company => @qufu, :lnt => 116.986212, :lat => 35.581933, :design => 40000)
#@rcws  = Factory.create!(:area => "任城区",     :name => "任城农污工程建设",     :company => @renc, :lnt => 116.605763, :lat => 35.444226, :design => 20000)
#@bhws  = Factory.create!(:area => "太白湖新区", :name => "北湖农污工程建设",     :company => @beih, :lnt => 116.595498, :lat => 35.349988, :design => 20000)
#@dsmt  = Factory.create!(:area => "微山县",     :name => "微山农污工程建设", :company => @jinx, :lnt => 117.129188,  :lat => 34.806657, :design => 20000)

User.create!(:phone => "053701013708", :password => "lsnwgc0101", :password_confirmation => "lsnwgc0101", :name => "中国建筑第六工程局有限公司",     :roles => @fctmgn,    :factories => [@lssw])
User.create!(:phone => "053709096688", :password => "zcnwgc0909", :password_confirmation => "zcnwgc0909", :name => "青岛亿联建设集团股份有限公司",     :roles => @fctmgn,    :factories => [@zcsw])
User.create!(:phone => "053745671111", :password => "jxnwgc4567", :password_confirmation => "jxnwgc4567", :name => "中建生态环境集团有限公司",     :roles => @fctmgn,    :factories => [@jxsw])
User.create!(:phone => "053701011818", :password => "yznwgc0101", :password_confirmation => "yznwgc0101", :name => "兖州农污工程建设管理者",     :roles => @fctmgn,    :factories => [@yzsw])
#User.create!(:phone => "053758586688", :password => "wsnwgc5858", :password_confirmation => "wsnwgc5858", :name => "汶上农污工程建设管理者",     :roles => @fctmgn,    :factories => [@wssw])
#User.create!(:phone => "053737089898", :password => "qfnwgc3708", :password_confirmation => "qfnwgc3708", :name => "曲阜农污工程建设管理者",     :roles => @fctmgn,    :factories => [@qfsw]) 
#User.create!(:phone => "053799996688", :password => "rcnwgc9999", :password_confirmation => "rcnwgc9999", :name => "任城农污工程建设管理者",     :roles => @fctmgn,    :factories => [@rcws]) 
#User.create!(:phone => "053767895678", :password => "bhnwgc6789", :password_confirmation => "bhnwgc6789", :name => "北湖农污工程建设管理者",     :roles => @fctmgn,    :factories => [@bhws]) 
#User.create!(:phone => "053712346688", :password => "dsnwgc6688", :password_confirmation => "dsnwgc6688", :name => "微山农污工程建设管理者",     :roles => @fctmgn,    :factories => [@dsmt])


all_factories = Factory.all
user.factories << all_factories

#集团运营
#grp_opt = User.create!(:phone => "15763703588", :password => "swjt3588", :password_confirmation => "swjt3588", :name => "水务集团运营", :roles => @grp_opt, :factories => all_factories)

#集团管理
grp_mgn = User.create!(:phone => "05376688", :password => "swjt0537", :password_confirmation => "swjt0537", :name => "水务集团管理者", :roles => @grp_mgn, :factories => all_factories)

