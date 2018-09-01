package tw.com.demo.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.ComponentScan
import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.view.InternalResourceViewResolver

@Configuration
@ComponentScan(Array(
  "tw.com.demo.controller",
  "tw.com.demo.bean"
))
class AppConfig {
  @Bean
  def viewResolver: InternalResourceViewResolver = {
    val viewResolver = new InternalResourceViewResolver()
    viewResolver setPrefix "/WEB-INF/pages/"
    viewResolver setSuffix ".jsp"
    viewResolver
  }
}
