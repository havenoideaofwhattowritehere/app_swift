import axios from 'axios';

const API_URL = 'http://localhost:8080/chats';

export default async function handler(req, res) {
    if (req.method === 'GET') {
        try {
            const response = await axios.get(API_URL);
            res.status(200).json(response.data);
        } catch (error) {
            res.status(500).json({ error: 'Failed to fetch chats' });
        }
    } else if (req.method === 'POST') {
        try {
            const response = await axios.post(API_URL, req.body);
            res.status(201).json(response.data);
        } catch (error) {
            res.status(500).json({ error: 'Failed to create chat' });
        }
    }
}
