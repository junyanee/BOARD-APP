package com.board.common.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BannerMaster {
	int idx;
	String title;
	String contents;
	String buttonCheck;
	String imageSrc;
	String buttonLink;
	String buttonContents;
	MultipartFile attachImage;

}

