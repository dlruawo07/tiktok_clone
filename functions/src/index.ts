/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// import { onRequest } from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

// 영상 생성 시 firebase에서 호출하는 함수
export const onVideoCreated = functions
  .region("asia-northeast3")
  // 아래 경로로 생성 시
  .firestore.document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    // 쉘에서의 명령어 호출되게 하는 것과 같게 해줌
    const { spawn } = require("child-process-promise");
    const video = snapshot.data();
    // ffmpeg 함수를 이용하여 1초의 프레임 한 개 추출 -> /tmp/${snapshot.id}.jpg에 저장
    await spawn("ffmpeg", [
      "-i",
      video.fileURL,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      `/tmp/${snapshot.id}.jpg`,
    ]);
    const storage = admin.storage();
    // tmp에 저장되어있는 썸네일을 storage에 저장
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await file.makePublic();
    // 영상의 정보 수정
    await snapshot.ref.update({ thumbnailURL: file.publicUrl() });

    // db의 users/uid/에 videos라는 컬렉션을 새로 만들고, snapshot.id의 문서를 만든 후 thumbnailURL과 videoId 정보를 넣어줌
    const db = admin.firestore();
    db.collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({ thumbnailURL: file.publicUrl(), videoId: snapshot.id });
  });

export const onLikedCreated = functions
  .region("asia-northeast3")
  .firestore.document("likes/{likeId}")
  .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("-");
    await db
      .collection("videos")
      .doc(videoId)
      .update({ likes: admin.firestore.FieldValue.increment(1) });
  });

export const onLikedRemoved = functions
  .region("asia-northeast3")
  .firestore.document("likes/{likeId}")
  .onDelete(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("-");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(-1),
      });
  });

// firebase functions 사용법:
// 1. 함수 생성 (특정 문서 경로 설정 후 반드시 onCreate, onDelete, onUpdate, onWrite 중 하나 구현)
// 2. onCreate, onDelete, onUpdate, onWrite의 콜백 함수의 첫 번째 인자는 snapshot으로 문서에 대한 정보를 담고 있다
// 3. 함수 구현할 때마다 firebase deploy --only functions 명령어를 실행해야 한다
