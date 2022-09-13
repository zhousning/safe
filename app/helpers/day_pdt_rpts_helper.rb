module DayPdtRptsHelper

  def options_for_my_factory(factories)
    str = ""
    factories.each do |f|
      str += "<option value='" + idencode(f.id).to_s + "'>" + f.name + "</option>"
    end

    raw(str)
  end

  def options_for_factories
    str = ""
    Factory.all.each do |f|
      str += "<option value='" + idencode(f.id).to_s + "'>" + f.name + "</option>"
    end

    raw(str)
  end

  def options_for_quotas
    str = ""
    quotas = Quota.all
    quotas.each do |f|
      title = f.name.gsub(/在线-|化验-/, '')
      str += "<option value='" + f.code.to_s + "'>" + title + "</option>"
    end

    raw(str)
  end

  def examine_state(examine)
    str = ''
    if examine.state == Setting.states.report
      str = '已上报水务集团'
    else
      str = '待上报'
    end
    str
  end

  def grp_review_state(review)
    str = ''
    if review.state == Setting.states.published
      str = '已发布'
    else
      str = '待发布'
    end
    str
  end

  def review_state(review)
    str = ""
    if review.state == Setting.states.created
      str = "<span class='text-dark border border-dark p-2'>待检查</span>"
    elsif review.state == Setting.states.modifying
      str = "<span class='text-danger border border-danger p-2'>已下整改</span>"
    elsif review.state == Setting.states.modified
      str = "<span class='text-info border border-info p-2'>已整改，待复检</span>"
    elsif review.state == Setting.states.review
      str = "<span class='text-warning border border-warning p-2'>已复检，待上报水务集团</span>"
    elsif review.state == Setting.states.report
      str = "<span class='text-primary border border-primary p-2'>已上报水务集团</span>"
    elsif review.state == Setting.states.reject
      str = "<span class='text-danger border border-danger p-2'>集团驳回</span>"
    elsif review.state == Setting.states.completed
      str = "<span class='text-success border border-success p-2'>已办结</span>"
    elsif review.state == Setting.states.good
      str = "<span class='text-success border border-success p-2'>检查完毕，无需整改</span>"
    end
    str.html_safe
  end

  def options_for_device_state
    [
      [Setting.devices.state_normal, Setting.devices.state_normal],
      [Setting.devices.state_repair, Setting.devices.state_repair],
      [Setting.devices.state_stop, Setting.devices.state_stop]
    ]
  end

  def options_for_mudfcts(factory)
    hash = Hash.new
    mudfcts = factory.mudfcts
    mudfcts.each do |f|
      hash[f.name] = f.id.to_s
    end
    hash
  end

  def mudfcts_hash(factory)
    hash = Hash.new
    mudfcts = factory.mudfcts
    mudfcts.each do |f|
      hash[f.id.to_s] = f.name
    end
    hash
  end

  def options_for_chemicals
    hash = Hash.new
    ctgs = ChemicalCtg.all
    ctgs.each do |f|
      hash[f.name] = f.code
    end
    hash
  end

  def chemicals_hash
    hash = Hash.new
    ctgs = ChemicalCtg.all
    ctgs.each do |f|
      hash[f.code] = f.name
    end
    hash
  end

  def options_for_emp_quotas
    str = "<option value='" + Setting.quota.cod + "'>" + cms_sub_pref(Setting.inf_qlties.cod) + "</option>" + "<option value='" + Setting.quota.nhn + "'>" + cms_sub_pref(Setting.inf_qlties.nhn) + "</option>" + "<option value='" + Setting.quota.tn + "'>" + cms_sub_pref(Setting.inf_qlties.tn) + "</option>" + "<option value='" + Setting.quota.tp + "'>" + cms_sub_pref(Setting.inf_qlties.tp) + "</option>"
    raw(str)
  end

  def options_for_years
    year = Time.new.year
    str = ""
    years = (2019..year).to_a.reverse
    years.each do |year|
      str += "<option value='" + year.to_s + "'>" + year.to_s + "</option>"
    end

    raw(str)
  end

  def options_for_mth_months
    str = ""
    months.each_pair do |k, v|
      str += "<option value='" + k + "'>" + v + "</option>"
    end
    raw(str)
  end

  def cms_sub_pref(title)
    title = title.gsub(/在线-|化验-/, '')
    title
  end

end  
