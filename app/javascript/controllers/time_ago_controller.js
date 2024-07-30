import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["output"];
  static values = { date: String };

  connect() {
    this.updateTime();
  }

  updateTime() {
    const datetime = new Date(this.dateValue);
    this.outputTarget.textContent = this.timeAgo(datetime);
  }

  timeAgo(date) {
    const now = new Date();
    const diff = now - date;

    const msInDay = 24 * 60 * 60 * 1000;
    const msInWeek = 7 * msInDay;
    const msInMonth = 30 * msInDay; // approximating a month as 30 days

    const months = Math.floor(diff / msInMonth);
    const weeks = Math.floor((diff % msInMonth) / msInWeek);
    const days = Math.floor((diff % msInWeek) / msInDay);

    return `${months > 0 ? months + " months, " : ""}${weeks > 0 ? weeks + " weeks, " : ""}${
      days > 0 ? days + " days " : ""
    } ago`;
  }
}
