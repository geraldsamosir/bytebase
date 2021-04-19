import { Factory } from "miragejs";
import faker from "faker";
import { UNKNOWN_ID } from "../../types";

export default {
  stage: Factory.extend({
    creatorId() {
      return UNKNOWN_ID;
    },
    createdTs(i) {
      return Date.now() - (i + 1) * 1800 * 1000;
    },
    updaterId() {
      return UNKNOWN_ID;
    },
    lastUpdatedTs(i) {
      return Date.now() - i * 3600 * 1000;
    },
    name(i) {
      return faker.fake("{{lorem.sentence}}");
    },
    type() {
      return "bytebase.stage.unknown";
    },
    status() {
      return "PENDING";
    },
    databaseId() {
      return UNKNOWN_ID;
    },
  }),
};