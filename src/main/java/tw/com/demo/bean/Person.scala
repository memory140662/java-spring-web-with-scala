package tw.com.demo.bean

import org.springframework.context.annotation.Bean

import scala.beans.BeanProperty

@Bean
class Person(@BeanProperty var name: String, @BeanProperty var age: Int) extends Serializable {

}
