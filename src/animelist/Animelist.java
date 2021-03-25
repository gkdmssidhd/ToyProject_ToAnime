package animelist;

public class Animelist {
	private int animeID;
	private String animeTitle;
	private String peopleID;
	private String animeDate;
	private String animeContent;
	private String animeType;
	private String animeCandy;
	private int animeAvailable;
	
	public int getAnimeID() {
		return animeID;
	}
	public void setAnimeID(int animeID) {
		this.animeID = animeID;
	}
	public String getAnimeTitle() {
		return animeTitle;
	}
	public void setAnimeTitle(String animeTitle) {
		this.animeTitle = animeTitle;
	}
	public String getPeopleID() {
		return peopleID;
	}
	public void setPeopleID(String peopleID) {
		this.peopleID = peopleID;
	}
	public String getAnimeDate() {
		return animeDate;
	}
	public void setAnimeDate(String animeDate) {
		this.animeDate = animeDate;
	}
	public String getAnimeContent() {
		return animeContent;
	}
	public void setAnimeContent(String animeContent) {
		this.animeContent = animeContent;
	}
	public String getAnimeType() {
		return animeType;
	}
	public void setAnimeType(String animeType) {
		this.animeType = animeType;
	}
	public String getAnimeCandy() {
		return animeCandy;
	}
	public void setAnimeCandy(String animeCandy) {
		this.animeCandy = animeCandy;
	}
	public int getAnimeAvailable() {
		return animeAvailable;
	}
	public void setAnimeAvailable(int animeAvailable) {
		this.animeAvailable = animeAvailable;
	}
	@Override
	public String toString() {
		return "Animelist [animeID=" + animeID + ", animeTitle=" + animeTitle + ", peopleID=" + peopleID
				+ ", animeDate=" + animeDate + ", animeContent=" + animeContent + ", animeType=" + animeType
				+ ", animeCandy=" + animeCandy + ", animeAvailable=" + animeAvailable + "]";
	}
	
	
}
