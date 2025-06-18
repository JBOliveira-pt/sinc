package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public interface FileStorageService {
    public String storeFile(MultipartFile file) throws IOException;
}
