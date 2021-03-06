require "intelmap_checker/version"
require 'selenium-webdriver'

class IntelmapChecker
  def initialize(email, passwd)
    @email = email
    @passwd = passwd
    @auth = nil
    begin
      @driver = Selenium::WebDriver.for :chrome
      @driver.manage.window.resize_to(100,100)
    rescue Exception => e
      puts e.message
      puts e.backtrace
    end
  end

  def load_map(url)
    if @auth == nil
      @driver.navigate.to url
      @driver.find_element(:link_text, "Sign in").click
      sleep 3 #waiting to load a page

      @driver.find_element(:name, "Email").send_keys(@email)
      @driver.find_element(:name, "signIn").click
      sleep 3 #waiting to load a page

      e = @driver.find_element(:name, "Passwd")
      e.send_keys(@passwd)
      e.submit
      @auth = true
    else
      @driver.navigate.to url
    end
    sleep 5
  end

  def all_comments
    arr = Array.new
    @driver.find_element(:id, "pl_tab_all").click
    sleep 3

    all_logs = @driver.find_elements(:class, "plext")
    all_logs.each do |log|
      timestamp =  log.find_element(:class, "pl_timestamp_date").text
      player_class =  log.find_element(:class, "pl_nudge_player").attribute("class").split(" ", 2)
      message =  log.find_element(:class, "pl_content").text.split(/\s*[: | ]\s*/, 2)
      data = Hash.new
      data[:date] = timestamp
      data[:faction] = player_class[0]
      data[:username] = message[0]
      data[:comment] = message[1]
      arr.push data
    end
    return arr
  end

  def faction_comments
    arr = Array.new
    @driver.find_element(:id, "pl_tab_fac").click
    sleep 3

    fac_logs = @driver.find_elements(:class, "plext")
    fac_logs.each do |log|
      timestamp =  log.find_element(:class, "pl_timestamp_date").text
      message =  log.find_element(:class, "pl_content").text.split(/\s*[: | ]\s*/, 2)
      data = Hash.new
      data[:date] = timestamp
      data[:username] = message[0]
      data[:comment] = message[1]
      arr.push data
     end
     return arr
  end

  def portal_details
    sleep 5
    portal = Hash.new
      container = @driver.find_element(:id, "portal_info_windows")
      if container
        if container.find_element(:id, "portal_primary_title").css_value("color") == "rgba(255, 255, 255, 1)"
          portal[:name] = container.find_element(:id, "portal_primary_title").text
          portal[:level] = container.find_element(:id, "portal_level").text
          portal[:faction] = nil
          portal[:owner] = nil
          portal[:resonators] = []
          portal[:mods] = []
        else
          portal[:name] = container.find_element(:id, "portal_primary_title").text
          portal[:level] = container.find_element(:id, "portal_level").text
          portal[:faction] = container.attribute("class").split(" ", 2)[0]
          portal[:owner] = container.find_element(:id, "portal_capture_details").text
          resonators = container.find_elements(:class, "resonator")
          reso_arr = Array.new
          resonators.each do |reso|
            if reso.find_elements(:class, "resonator_owner").size > 0
              reso_data = Hash.new
              reso_data[:owner] = reso.find_element(:class, "resonator_owner").text
              reso_data[:level] = reso.find_element(:class, "resonator_level").text
              reso_arr.push reso_data
            end
          end
          portal[:resonators] = reso_arr
          reso_arr = Array.new

          container.find_element(:id, "pi-tab-mod").click
          mods = container.find_elements(:class, "mod")
          mod_arr = Array.new
          mods.each do |mod|
            if mod.find_elements(:class, "mod_installer").size > 0
              mod_data = Hash.new
              mod_data[:installer] = mod.find_element(:class, "mod_installer").text
              if mod.find_elements(:class, "mod_name_common").size > 0
                mod_data[:type] = mod.find_element(:class, "mod_name_common").text
                mod_data[:class] = "common"
              elsif mod.find_elements(:class, "mod_name_rare").size > 0
                mod_data[:type] = mod.find_element(:class, "mod_name_rare").text
                mod_data[:class] = "rare"
              elsif mod.find_elements(:class, "mod_name_very_rare").size > 0
                mod_data[:type] = mod.find_element(:class, "mod_name_very_rare").text
                mod_data[:class] = "very_rare"
              end
              mod_arr.push mod_data
            end
          end
          portal[:mods] = mod_arr
        end
      end
    return portal
  end

  def shutdown
    @driver.quit
  end

end
