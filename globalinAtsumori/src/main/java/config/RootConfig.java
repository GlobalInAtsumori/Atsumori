package config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = {"service", "controller", "config", "domain", "mapper"}) 
public class RootConfig {

	@Bean
	public DataSource dataSource() {
		HikariConfig config = new HikariConfig();
		config.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		config.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:orcl");
		config.setUsername("scott");
		config.setPassword("tiger");
		
		HikariDataSource ds = new HikariDataSource(config);
		return ds;
	}
	
	// MyBatis SqlSessionFactory 설정
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
        factory.setDataSource(dataSource);
        factory.setMapperLocations(
            new PathMatchingResourcePatternResolver().getResources("classpath:/mapper/*.xml")
        );
        
        factory.setTypeAliases(new Class[] {
                domain.MemberVO.class,
                domain.RestaurantVO.class,
                domain.ReviewImageVO.class,
            });
        
        return factory.getObject();
    }

    // SqlSessionTemplate 설정
    @Bean
    public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

    // Mapper 스캔 설정
    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
        MapperScannerConfigurer configurer = new MapperScannerConfigurer();
        configurer.setBasePackage("mapper");
        return configurer;
    }

    // 트랜잭션 매니저 설정
    @Bean
    public DataSourceTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
