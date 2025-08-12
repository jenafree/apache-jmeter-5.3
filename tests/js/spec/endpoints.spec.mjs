import fs from 'fs';
import path from 'path';
import request from 'supertest';

function readCsv(filePath) {
  const text = fs.readFileSync(filePath, 'utf-8').trim();
  const lines = text.split(/\r?\n/);
  const rows = [];
  for (let i = 1; i < lines.length; i++) {
    if (!lines[i].trim()) continue;
    const [name, method, url, bodyFile, expectedStatus] = lines[i].split(',');
    rows.push({ name, method, url, bodyFile, expectedStatus: Number(expectedStatus) });
  }
  return rows;
}

const csvPath = path.join(process.cwd(), 'tests', 'specs', 'endpoints.csv');
const cases = readCsv(csvPath);

describe('API contract - reqres.in', () => {
  for (const c of cases) {
    test(c.name, async () => {
      const api = request(c.url);
      let req = api;
      let body = undefined;
      if (c.bodyFile) {
        const bodyPath = path.join(process.cwd(), 'tests', 'specs', 'bodies', c.bodyFile);
        body = JSON.parse(fs.readFileSync(bodyPath, 'utf-8'));
      }
      let res;
      switch (c.method.toUpperCase()) {
        case 'GET': res = await req.get(''); break;
        case 'POST': res = await req.post('').send(body); break;
        case 'PUT': res = await req.put('').send(body); break;
        case 'PATCH': res = await req.patch('').send(body); break;
        case 'DELETE': res = await req.delete(''); break;
        default: throw new Error(`Unsupported method: ${c.method}`);
      }
      expect(res.status).toBe(c.expectedStatus);
    }, 30000);
  }
});


