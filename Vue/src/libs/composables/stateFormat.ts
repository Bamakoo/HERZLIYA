import type { Books } from '../interfaces/books'

export const stateFormat = (state: Books['state']) =>
  state === 'horrendous'
    ? 'Horrible'
    : state === 'bad'
    ? 'Mauvais'
    : state === 'okay'
    ? 'Okay'
    : state === 'passable'
    ? 'Passable'
    : state === 'acceptable'
    ? 'Acceptable'
    : state === 'good'
    ? 'Bon État'
    : state === 'excellent'
    ? 'Excellent'
    : 'Neuf'
