package tw.com.demo.config

import org.springframework.web.WebApplicationInitializer
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext
import org.springframework.web.servlet.DispatcherServlet

import javax.servlet.ServletContext

class MyWebApplicationInitializer extends WebApplicationInitializer {
  override def onStartup(servletContext: ServletContext): Unit = {
    val ac = new AnnotationConfigWebApplicationContext()
    ac register classOf[AppConfig]
    ac refresh()

    val servlet = new DispatcherServlet(ac)
    val registration = servletContext addServlet("main", servlet)
    registration setLoadOnStartup 1
    registration addMapping "/"
  }
}
