package service;

import java.io.IOException;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;

import lombok.RequiredArgsConstructor;

@Service
public class S3Service {
	private final AmazonS3 s3Client;
	private final String bucketName = "globalin-atsumori-bucket";

	public S3Service(@Value("${s3.access.key}") String accessKey, @Value("${s3.secret.key}") String secretKey) {
		BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKey, secretKey);

		this.s3Client = AmazonS3ClientBuilder.standard().withRegion("ap-northeast-2")
				.withCredentials(new AWSStaticCredentialsProvider(awsCreds)).build();
	}

	public String uploadFile(MultipartFile file) throws IOException {
		if (file == null || file.isEmpty()) {
			throw new IllegalArgumentException("업로드할 파일이 없습니다.");
		}

		// 파일명 UUID + 원래 확장자
		String extension = FilenameUtils.getExtension(file.getOriginalFilename());
		String fileName = UUID.randomUUID().toString() + (extension.isEmpty() ? "" : "." + extension);

		// S3 메타데이터 설정 (콘텐츠 타입)
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentLength(file.getSize());
		metadata.setContentType(file.getContentType());

		// S3 업로드
		s3Client.putObject(bucketName, fileName, file.getInputStream(), metadata);

		// 업로드된 파일 URL 반환
		return s3Client.getUrl(bucketName, fileName).toString();
	}
}
