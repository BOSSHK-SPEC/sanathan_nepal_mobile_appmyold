import type { Messages } from '../types';
import docs from './en.docs';

export default {
  meta: {
    title: 'Sanatan Nepal',
    description: 'The calendar, the stars and the puja room in one app, for Nepal and India. Staff sign in to the Sanatan console.',
  },
  skip: 'Skip to staff sign in',
  brandLabel: 'Sanatan Nepal, back to the start',
  rail: {
    river: { term: 'दीप', termLang: 'ne', name: '' },
    sky: { term: 'नवग्रह', termLang: 'sa', name: '' },
    temple: { term: 'न्यातपोल', termLang: 'ne', name: '' },
    yantra: { term: 'श्रीयन्त्र', termLang: 'sa', name: '' },
  },
  signIn: 'Staff sign in',
  language: { button: 'Language', heading: 'Choose a language', changed: 'Page language changed to English' },
  hero: {
    label: { term: 'ॐ', termLang: 'sa', name: 'Nepal and India' },
    lead: 'The calendar, the stars and the puja room — in one app, in Nepali, Hindi and English.',
    cue: 'Scroll to begin',
  },
  views: [
    {
      label: { term: 'पात्रो', termLang: 'ne', name: 'Calendar' },
      title: 'Bikram Sambat, day by day.',
      body: 'Tithis, festivals and public holidays for any date — and the Saka calendar for India.',
    },
    {
      label: { term: 'पञ्चाङ्ग', termLang: 'sa', name: 'Panchanga' },
      title: 'Tithi, nakshatra, yoga, karana, var.',
      body: 'The five limbs of every day, sunrise for your city, and a vrat reminder the evening before.',
    },
    {
      label: { term: 'नवग्रह', termLang: 'sa', name: 'Horoscope' },
      title: 'Nine grahas, read for you.',
      body: 'Daily, weekly, monthly and yearly horoscopes for all twelve rashis.',
    },
    {
      label: { term: 'चन्द्र', termLang: 'sa', name: 'Kundli' },
      title: 'Your rashi is where the moon stood.',
      body: 'Birth charts from the minute you were born, and guna milan scored out of 36.',
    },
    {
      label: { term: 'गुरु', termLang: 'sa', name: 'Astrologers' },
      title: 'Astrologers you can actually call.',
      body: 'Verified astrologers by voice or video, billed by the minute from your wallet.',
    },
    {
      label: { term: 'न्यातपोल', termLang: 'ne', name: 'Puja' },
      title: 'A pandit at your door.',
      body: 'Book a puja at home or at the temple, from the same app that told you the day.',
    },
    {
      label: { term: 'बजार', termLang: 'ne', name: 'Marketplace' },
      title: 'Samagri from sellers we approved.',
      body: 'Rudraksha, idols, books and puja kits from businesses our team has checked.',
    },
    {
      label: { term: 'गजुर', termLang: 'ne', name: 'Wallet' },
      title: 'One wallet, two countries.',
      body: 'Pay with eSewa, Khalti or a bank in Nepal — UPI, cards or net banking in India.',
    },
    {
      label: { term: 'भूपुर', termLang: 'sa', name: 'Languages' },
      title: 'Every door opens on the same centre.',
      body: 'The app speaks Nepali, Hindi and English, and shows prices in Nepali and Indian rupees.',
    },
    {
      label: { term: 'षोडशदल', termLang: 'sa', name: 'Trust' },
      title: 'Kept honest by people, not just code.',
      body: 'Astrologers are verified, sellers approved, payouts reconciled — and every staff action is written to the audit log.',
    },
    {
      label: { term: 'बिन्दु', termLang: 'sa', name: 'Staff console' },
      title: 'The centre is where the work happens.',
      body: 'For moderators, finance and support. Everyone else uses the app.',
    },
  ],
  footer: 'for Nepal and India',
  suggest: { prompt: 'Read this page in English?', accept: 'Switch to English', dismiss: 'No thanks' },
  scene: {
    words: ['पात्रो', 'पञ्चाङ्ग'],
    rashis: ['मेष', 'वृषभ', 'मिथुन', 'कर्क', 'सिंह', 'कन्या', 'तुला', 'वृश्चिक', 'धनु', 'मकर', 'कुम्भ', 'मीन'],
  },
  ...docs,
} satisfies Messages;
