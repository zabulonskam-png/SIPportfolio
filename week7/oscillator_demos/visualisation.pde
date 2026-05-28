void waveViz() {
  background(50);
  stroke(255);
  strokeWeight(2);
  noFill();

  // Perform the analysis
  waveform.analyze();

  // draw a waveform
  beginShape();
  for (int i = 0; i < waveformSamples; i++) {
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    vertex(
      map(i, 0, waveformSamples, 0, width), 
      map(waveform.data[i], -1, 1, 0, height)
      );
  }
  endShape();
}

void fftViz() {
  background(50);
  fft.analyze(spectrum);

  for (int i = 0; i < fftBands; i++) {
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    line( i, height, i, height - spectrum[i]*height*5 );
  }
}
