#!/bin/bash

# Script to generate all UPSC-related migrations

echo "Generating UPSC migrations..."

# Core tables
rails generate migration CreateUpscTopics
rails generate migration CreateUpscStudentProfiles
rails generate migration CreateUpscQuestions
rails generate migration CreateUpscTests
rails generate migration CreateUpscTestQuestions
rails generate migration CreateUpscUserTestAttempts
rails generate migration CreateUpscWritingQuestions
rails generate migration CreateUpscUserAnswers
rails generate migration CreateUpscNewsArticles
rails generate migration CreateUpscStudyPlans
rails generate migration CreateUpscDailyTasks
rails generate migration CreateUpscRevisions
rails generate migration CreateUpscUserProgress

echo "All migrations generated!"
