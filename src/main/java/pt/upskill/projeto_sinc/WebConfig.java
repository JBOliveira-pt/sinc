package pt.upskill.projeto_sinc;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//CONFIGURAÇÃO PARA GENERALIZAR A LOCALIZAÇÃO DOS SCRIPTS E DOS FICHEIROS DE UPLOAD
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Value("${file.upload-dir}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/scripts/**").addResourceLocations("/WEB-INF/scripts/");
        registry.addResourceHandler("/uploads/**").addResourceLocations("file:" + uploadDir + "/");
    }
}