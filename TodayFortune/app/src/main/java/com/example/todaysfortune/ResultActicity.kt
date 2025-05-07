package com.example.todaysfortune

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.Card
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.todaysfortune.ui.theme.TodaysFortuneTheme
import kotlin.random.Random

class ResultActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TodaysFortuneTheme {
                ResultScreen()
            }
        }
    }
}

@Composable
fun ResultScreen() {
    val context = LocalContext.current

    val fortune = Random.nextInt(0, 101)  // 0-100 사이의 랜덤 숫자
    val fortuneText = when (fortune) {
        in 90..100 -> "🌟 Excellent Fortune!"
        in 70..89 -> "😊 Good Fortune!"
        in 50..69 -> "😐 Average Fortune."
        in 30..49 -> "😕 Poor Fortune."
        else -> "💀 Bad Luck!"
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        contentAlignment = Alignment.Center
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = fortune.toString(),
                style = androidx.compose.ui.text.TextStyle(
                    color = Color(0xFF89CFF0),
                    fontSize = 64.sp
                )
            )
            Spacer(modifier = Modifier.height(16.dp))
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                shape = RoundedCornerShape(16.dp),
            ) {
                Column(
                    modifier = Modifier
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(
                        text = fortuneText,
                        color = Color.White,
                        fontSize = 24.sp
                    )
                }
            }
            Spacer(modifier = Modifier.height(24.dp))
            Button(
                onClick = {
                    context.startActivity(Intent(context, LoadingActivity::class.java))
                },
                modifier = Modifier.fillMaxWidth().height(50.dp),
                colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFF89CFF0)
                ),
            ) {
                Text(text = "Try Again", color = Color.White)
            }
            Spacer(modifier = Modifier.height(8.dp))
            Button(
                onClick = {
                    context.startActivity(Intent(context, MainActivity::class.java))
                },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(50.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.White
                ),
                border = BorderStroke(1.dp, Color(0xFF89CFF0)) // 연한 하늘색 테두리
            ) {
                Text(text = "Go Back to Main", color = Color(0xFF89CFF0))
            }

        }
    }
}

@Preview(showBackground = true)
@Composable
fun ResultScreenPreview() {
    TodaysFortuneTheme {
        ResultScreen()
    }
}
