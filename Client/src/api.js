const API_URL = "https://localhost:7126/api/MotionPictures";

async function api_getAll() {
  // TODO:
  // 1. Error handling (same overall as POST)
  return await (await fetch(API_URL)).json();
}

async function api_post(payload) {
  let response;
  try {
    response = await fetch(API_URL, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify(payload),
    });
  } catch (error) {
    console.log(error);
  } finally {
    if (!response.ok) {
      console.log("Server responded with an error");
      return false;
    } else return true;
  }
}

async function api_put(payload) {
  let response;
  try {
    response = await fetch(API_URL + `/${payload.id}`, {
      method: "PUT",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify(payload),
    });
  } catch (error) {
    console.log(error);
  } finally {
    if (!response.ok) {
      console.log("Server responded with an error");
      return false;
    } else return true;
  }
}

async function api_delete(id) {
  let response;
  try {
    response = await fetch(API_URL + `/${id}`, { method: "DELETE" });
  } catch (error) {
    console.log(error);
  } finally {
    if (!response.ok) {
      console.log("Server responded with an error");
      return false;
    } else return true;
  }
}

export { api_getAll, api_post, api_put, api_delete };
