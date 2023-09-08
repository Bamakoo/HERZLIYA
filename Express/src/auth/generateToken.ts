import { init } from "@paralleldrive/cuid2";
export const createId = init({
  random: Math.random,
  length: 10,
  // A custom fingerprint for the host environment. This is used to help
  // prevent collisions when generating ids in a distributed system.
  fingerprint: "a-custom-host-fingerprint",
});
