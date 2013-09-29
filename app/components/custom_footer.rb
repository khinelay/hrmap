class CustomFooter < ActiveAdmin::Component
  def build
    super(id: "footer")
    para t('site.footer.copyright', year: Time.now.year, company: SETTINGS[:company], powered_by: link_to("HR Map", "https://github.com/ducknorris/hrmap", target: "_blank")).html_safe
  end
end
