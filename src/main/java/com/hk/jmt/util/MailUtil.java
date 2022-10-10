package com.hk.jmt.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.hk.jmt.common.Vo.Mail;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access=AccessLevel.PRIVATE)
@Component
public class MailUtil {
	@Autowired
	private JavaMailSender mailSender;
	public void sendMail(Mail mail) throws MessagingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		messageHelper.setFrom(mail.getSender());
		messageHelper.setTo(mail.getReceiver());
		messageHelper.setSubject(mail.getTitle());
		messageHelper.setText(mail.getContent(), true);
		mailSender.send(message);
}
}