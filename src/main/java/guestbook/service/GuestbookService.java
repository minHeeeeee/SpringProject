package guestbook.service;

import java.util.List;
import java.util.Map;

import guestbook.bean.GuestbookDTO;
import guestbook.bean.GuestbookPaging;



public interface GuestbookService {

	public void guestbookWrite(Map<String, String> map);

	public List<GuestbookDTO> getGuestbookList(String pg);

	public GuestbookDTO getGuestbookView(String seq);

	public GuestbookPaging guestbookPaging(String pg);

	public void guestbookDelete(String seq);

	public void guestbookModify(Map<String, String> map);

}
