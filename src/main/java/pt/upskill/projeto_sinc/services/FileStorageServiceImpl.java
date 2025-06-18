package pt.upskill.projeto_sinc.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class FileStorageServiceImpl implements FileStorageService {

    @Value("${file.upload-dir:src/main/resources/static/uploads}")
    private String uploadDir;

    @Override
    public String storeFile(MultipartFile file) throws IOException {
        File directory = new File(uploadDir + "/profile-pictures");
        if (!directory.exists()) {
            directory.mkdirs();
        }
        String filename = UUID.randomUUID() + "-" + file.getOriginalFilename();
        Path targetLocation = Paths.get(directory.getAbsolutePath(), filename);
        Files.copy(file.getInputStream(), targetLocation);
        return "/uploads/profile-pictures/" + filename;
    }
}