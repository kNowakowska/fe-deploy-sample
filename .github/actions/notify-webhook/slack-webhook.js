import axios from 'axios';
const { SLACK_WEBHOOK_URL, MESSAGE, TYPE } = process.env;

if (!SLACK_WEBHOOK_URL) throw new Error('SLACK_WEBHOOK_URL is required');

if (!MESSAGE) throw new Error('MESSAGE is required');

const requestConifg = { url: SLACK_WEBHOOK_URL, message: MESSAGE, type: TYPE || 'good' };

async function notifySlack(config) {
  try {
    await axios.post(config.url, {
      text: 'Github Actions',
      attachments: [
        {
          color: config.type,
          text: config.message,
        },
      ],
    });
  } catch (err) {
    console.error(err);
  }
}

await notifySlack(requestConifg);
